Shader "Custom/Transparencia"
{
	Properties
	{
		//surface
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_Glossiness("Smoothness", Range(0,1)) = 0.5
		_Metallic("Metallic", Range(0,1)) = 0.0

		//vertex
		_Altura("Altura", Range(-1,1)) = 0.3
		_Anchura("Anchura", Range(0,1)) = 0.2
		_Amplitud("Amplitud", Range(0,1)) = 0.4
		_Movimiento("Movimiento", Range(0,10)) = 5.0
	}
		SubShader
			{
				
				Tags { "RenderType" = "Opaque" }
				LOD 200

				CGPROGRAM
				// Physically based Standard lighting model, and enable shadows on all light types
				#pragma surface surf Standard fullforwardshadows vertex:vert addshadow

				/* Physically based Standard lighting model, and enable shadows on all light types
				#pragma surface surf Standard fullforwardshadows*/

				// Use shader model 3.0 target, to get nicer looking lighting
				#pragma target 3.0

				//Declaramos las variables
				//sampler2D _TexturaDisolucion;
				sampler2D _MainTex;

				struct Input
				{
					float2 uv_MainTex;
				};

				half _Glossiness;
				half _Metallic;
				
				//vertex
				half _Altura;
				half _Anchura;
				half _Amplitud;
				half _Movimiento;

				// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
				// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
				// #pragma instancing_options assumeuniformscaling
				UNITY_INSTANCING_BUFFER_START(Props)
					// put more per-instance properties here
				UNITY_INSTANCING_BUFFER_END(Props)

			
				void surf(Input IN, inout SurfaceOutputStandard o)
				{

					//Obtenemos valor pixel de la textura imagen

					fixed4 c = tex2D(_MainTex, IN.uv_MainTex) ;
					
					//Si el valor no es negro aplicamos las propiedades sino descartamos el pixel
					if (c.r > 0.04 || c.g > 0.04 || c.b > 0.0) {
						o.Albedo = c.rgb;
						o.Metallic = _Metallic;
						o.Smoothness = _Glossiness;
						o.Alpha = c.a;
					}
						
					else {
						//La función clip () descarta un píxel si alguno de sus valores componentes es menor que 0

						clip(-1.0);

					}
					
				}

				// Función del vertex shader 
				void vert(inout appdata_full v) {
					half3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;

					v.vertex.y += sin(worldPos.x + _Movimiento) * _Amplitud;	
						

				}
				ENDCG
			}
				FallBack "Diffuse"
}
