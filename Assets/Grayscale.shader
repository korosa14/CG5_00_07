Shader "Unlit/Grayscale"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;


            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed Gaussian(float2 drawUV,float2 pickUV,float sigma)
            {
                float d = distance(drawUV,pickUV);
                return exp(-(d*d)/(2*sigma*sigma));
            }

            fixed4 frag (v2f i) : SV_Target
            {
                //00_07
                fixed4 col=tex2D(_MainTex,i.uv);
                fixed grayScale=col.r*0.299+col.g*0.587+col.b*0.114;
                fixed4 color=fixed4(grayScale,grayScale,grayScale,1);

                return color;

                //00_08

                // float totaWeight=0, _Sigma=0.005, _StepWidth=0.001;
                // fixed4 col=fixed4(0,0,0,0);
                
                // for(float py=-_Sigma*2;py<=_Sigma*2;py+=_StepWidth)
                // {
                //     for(float px=-_Sigma*2;px<=_Sigma*2;px+=_StepWidth)
                //     {
                //         float2 pickUV=i.uv+float2(px,py);
                //         fixed weight=Gaussian(i.uv,pickUV,_Sigma);
                //         col+=tex2D(_MainTex,pickUV)*weight;
                //         totaWeight+=weight;
                //     }
                // }
                // col.rgb=col.rgb/totaWeight;
                // col.a=1;
                // return col;
            }
            ENDCG
        }
    }
}
