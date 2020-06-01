Shader "Custom/Ruido"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_Glossiness("Smoothness", Range(0,1)) = 0.5
		_Metallic("Metallic", Range(0,1)) = 0.0

			//Nuevas propiedades
			 _TextRuido("TexturaRuido (RGB)", 2D) = "white" {}
			_Intensidad("Intensidad", Range(-0.1,0.1)) = 0.0
	}
		SubShader
			{
				Tags { "RenderType" = "Opaque" }
				LOD 200

				CGPROGRAM

				// Physically based Standard lighting model, and enable shadows on all light types
				#pragma surface surf Standard fullforwardshadows

				// Use shader model 3.0 target, to get nicer looking lighting
				#pragma target 3.0

				//Declaramos las propiedades
				sampler2D _MainTex;
				sampler2D _TextRuido;

				struct Input
				{
					float2 uv_MainTex;
					float2 uv_TextRuido;
				};

				half _Glossiness;
				half _Metallic;
				fixed4 _Color;

				half _Intensidad;

				// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
				// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
				// #pragma instancing_options assumeuniformscaling
				UNITY_INSTANCING_BUFFER_START(Props)
					// put more per-instance properties here
				UNITY_INSTANCING_BUFFER_END(Props)

				void surf(Input IN, inout SurfaceOutputStandard o)
				{

					// Albedo comes from a texture tinted by color

					fixed4 c = tex2D(_TextRuido, IN.uv_TextRuido) * _Color;			// En la variable c almacenamos la información por pixel de la textura Ruido

					//Creamos un variable de dos componentes para guardar el valor 'x e 'y' . Esto marcara el desplazamiento de la textura principal que sera proporcional a la Intesisad

					half2 des = c.xy * _Intensidad + 0.001 * sin(_Time.xy * 10);	//Usamos la ecuacion de una onda para modificar los valores para crear el efecto ruido --> Amplitud sin(angulo)

					fixed4 a = tex2D(_MainTex, IN.uv_MainTex + des) * _Color;		//Guardamos los pixeles de la textura principal

					o.Albedo = a.rgb;		//La insertamos en Albedo



					// Metallic and smoothness come from slider variables
					o.Metallic = _Metallic;
					o.Smoothness = _Glossiness;
					o.Alpha = c.a;
				}
			
				// Función del vertex shader 
				/*void vert(inout appdata_full v) {
					half3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;

					v.vertex.y += sin(worldPos.x + _Movimiento) * _Amplitud;


				}*/
				ENDCG
			}
				FallBack "Diffuse"
}
