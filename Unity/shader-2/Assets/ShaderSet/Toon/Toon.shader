﻿Shader "Custom/Toon"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Ramptex ("Ramp", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf ToonRamp
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _Ramptex;

        struct Input {
            float2 uv_MainTex;
        };

        fixed4 _Color;

        fixed4 LightingToonRamp (SurfaceOutput s, fixed3 lightDir, fixed atten) {
            half d = dot(s.Normal, lightDir) * 0.5 + 0.5;
            fixed3 ramp = tex2D(_Ramptex, fixed2(d, 0.5)).rgb;
            fixed4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * ramp;
            c.a = 0;
            return c;
        }

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
