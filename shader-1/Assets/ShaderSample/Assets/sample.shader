﻿Shader "Custom/NewSurfaceShader"
{
    //インスペクタに公開する変数 uniformのことかな？
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _BaseColor("Base Color", Color) = (1, 1, 1, 1)  //インスペクタから変更可能になる
    }
    //シェーダの設定項目
    SubShader
    {
        Tags { "Queue"="Transparent" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard alpha:fade
        
        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        /**
         * ここからメインプログラム
        */
        sampler2D _MainTex;

        //Vertexシェーダから出力された値の入力地点（Input構造体）
        struct Input
        {
            float2 uv_MainTex;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        fixed4 _BaseColor;  //スクリプトから変更可能にしたい
        //o = output構造体
        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = fixed4(0.6f, 0.7f, 0.4f, 1);  //マテリアルの基本色を設定（黒っぽく）
            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = 0.4;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
