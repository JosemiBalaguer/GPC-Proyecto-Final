Shader "Custom/Transparencia"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_Glossiness("Smoothness", Range(0,1)) = 0.5
		_Metallic("Metallic", Range(0,1)) = 0.0

			// Nuevas propiedades

		_ColorE("ColorEmision", Color) = (1,0.5,0,1)
			//_TexturaDisolucion("TexturaDisolucion (RGB)", 2D) = "white" {}
			_ValorUmbral("Umbral", Range(0,1)) = 0.3
			_RangoEfecto("Efecto", Range(0,1)) = 0.5

			_Black("ColorTransparencia", Color) = (0,0,0)
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

				//Declaramos las variables
				//sampler2D _TexturaDisolucion;
				sampler2D _MainTex;

				struct Input
				{
					//float2 uv_TexturaDisolucion;
					float2 uv_MainTex;
				};

				half _Glossiness;
				half _Metallic;
				half _ValorUmbral;
				half _RangoEfecto;
				fixed4 _Color;
				fixed4 _ColorE;
				fixed4 _Black;
				//fixed4 _Emission;

				// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
				// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
				// #pragma instancing_options assumeuniformscaling
				UNITY_INSTANCING_BUFFER_START(Props)
					// put more per-instance properties here
				UNITY_INSTANCING_BUFFER_END(Props)

				void surf(Input IN, inout SurfaceOutputStandard o)
				{

					//Obtenemos valor pixel de la textura principal

					fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
					
					//Si ese valor es negro lo borramos (descartamos)
					if (c.x == _Black.x && c.y == _Black.y && c.z == _Black.z)
						clip(c);
					else {


						o.Albedo = c.rgb;
						//o.Emission = _ColorE;

						/*//Obtenemos el valor de la textura de la disolucion
						float d = tex2D(_TexturaDisolucion, IN.uv_TexturaDisolucion).r;

						//1º Se descartan aquellos pixeles que su valor es menor que el Umbral

						clip(d - _ValorUmbral);

						//2º si es mayor que umbral (albedo --> maintext)

						if (d > _ValorUmbral)
						{
							o.Albedo = c.rgb;
							if (d < _ValorUmbral + _RangoEfecto)		// 3º Si esta entre Umbral y Umbral + Rango presenta emision
								o.Emission = _ColorE;
						}*/

						o.Metallic = _Metallic;
						o.Smoothness = _Glossiness;
						o.Alpha = c.a;
					}
				}
				ENDCG
			}
				FallBack "Diffuse"
}
