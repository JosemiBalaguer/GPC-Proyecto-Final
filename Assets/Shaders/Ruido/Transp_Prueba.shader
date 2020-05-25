Shader "Custom/Transp_Prueba"
{

		Properties
		{
			_Color("Color", Color) = (1,1,1,1)
			_MainTex("Albedo (RGB)", 2D) = "white" {}
			_Glossiness("Smoothness", Range(0,1)) = 0.5
			_Metallic("Metallic", Range(0,1)) = 0.0

			// Nuevas propiedades

			_Transparency("Transparency", Range(0.0,0.5)) = 0.25
	
		}
			SubShader
			{
				Tags { "Queue" = "Transparent" "RenderedType" = "Transparent" }
				LOD 200 // o LOD 100
				Zwrite Off
				Blend SrcAlpha OneMinusSrcAlpha

				Pass{
					CGPROGRAM
					#pragma vertex vert
					#pragma fragment frag

					#include "UnityCG.cginc"

					struct appdata {

						float4 vertex : POSITION;
						float2 uv : TEXCOORD0;
					};

					struct v2f {

						float2 uv : TEXTCOORD0;
						float4 vertex : SV_POSITION;
					};

					sampler2D _MainTex;
					float4 _MainTex_ST;
					float4 _TintColor;
					float _Transparency;

					v2f vert(appdata v) {
						v2f o;
						o.vertex = UnityObjectToClipPos(v.vertex);
						o.uv = TRANSFORM_TEX(v.uv, _MainTex);
						return o;
					}
					fixed4 frag(v2f i) : SV_Target{
						//sample the texture

						fixed4 col = tex2D(_MainTex, i.uv) + _TintColor;
						col.a = _Transparency;
						return col;

					}
						ENDCG

				}
			}
	}

				