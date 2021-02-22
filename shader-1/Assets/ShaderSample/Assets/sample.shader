Shader "Custom/NewSurfaceShader"
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
        // *** Queue: 描画の優先度
        Tags { "Queue"="Transparent" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard alpha:fade  // *** alpha: fade　追加
        
        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        /**
         * ここからメインプログラム
        */
        sampler2D _MainTex;

        //Vertexシェーダから出力された値の入力地点（Input構造体）
        struct Input
        {
            float3 worldNormal;  // *** 法線ベクトル
            float3 viewDir;  //視線ベクトル
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
            o.Albedo = fixed4(1, 1, 1, 1);
            float alpha = 1 - (abs(dot(IN.viewDir, IN.worldNormal)));  //二つのベクトルの内積を計算し、1から引くことによって輪郭部分の透明度を1、中央部分を0にしている
            o.Alpha = alpha * 1.5f;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
