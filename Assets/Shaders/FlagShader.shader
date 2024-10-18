Shader "Unlit/FlagShader"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        _WindStrength("Wind Strength", Float) = 1.0
        _WindDirection("Wind Direction", Vector) = (1, 0, 0)
        _TimeScale("Time Scale", Float) = 1.0
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
            float4 _MainTex_ST;
            float _WindStrength;
            float3 _WindDirection;
            float _TimeScale;

            v2f vert (appdata v)
            {
                v2f o;
                float wave = sin(v.vertex.x * 5.0 + _Time.y * _TimeScale) * _WindStrength;
                v.vertex.y += wave; // Modifica la altura de los vértices según el viento
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                return col;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
