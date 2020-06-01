Shader "Custom/inflar"
{
	
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0

		// Nuevas propiedades
	
		_Inflado("Inflado", Range(0,1)) = 0.4

		
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows vertex:vert addshadow

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

		//Declaramos las variables
        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

		half _Inflado;
		
		/*bool cont = false;*/

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)


		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);	//Guardamos la informacion del pixel de la textura principal
			if (c.r > 0.04 || c.g > 0.04 || c.b > 0.0)
				/*cont = true;*/
			o.Albedo = c.rgb;										//La insertamos en Albedo
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;

		}


		// Función del vertex shader 
		void vert(inout appdata_full v) {
			
			half3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
			/*if (cont == 2000) {
				cont = 0;
				v.vertex.x += sin(v.normal.x) * _Inflado;
				v.vertex.z += sin(v.normal.z) * _Inflado;
			}
			else
				cont++;*/
			/*if (cont) {
				v.vertex.x += sin(v.normal.x) * _Inflado;
				v.vertex.z += sin(v.normal.z) * _Inflado;
			}*/
			v.vertex.x += v.normal.x  * _Inflado;
			v.vertex.z += v.normal.z  * _Inflado;
			v.vertex.y += v.normal.y * _Inflado;
			
			/*if ((v.vertex.y <= (_Altura + _Anchura )) && (v.vertex.y >= (_Altura - _Anchura)))	//Comprobamos que esta en el rango a
			{
				v.vertex.x += v.normal.x  * _Inflado;	//Para producir la deformación deseada es necesario modificar en nuestro caso la coordenada 'x' y 'z' del vertex. Esta sera proporcional al Inflado
				v.vertex.z += v.normal.z * _Inflado;		
			}*/
			
			
		}

       
        ENDCG
    }
    FallBack "Diffuse"
}
