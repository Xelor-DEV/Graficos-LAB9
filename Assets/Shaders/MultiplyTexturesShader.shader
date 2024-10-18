Shader "Unlit/MultiplyTexturesShader"
{
    Properties
    {
        _MainTex("Texture 1", 2D) = "white" {}
        _SecondTex("Texture 2", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            sampler2D _SecondTex;
            float4 _MainTex_ST;
            float4 _SecondTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 tex1 = tex2D(_MainTex, i.uv);
                fixed4 tex2 = tex2D(_SecondTex, i.uv);
                return tex1 * tex2;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
