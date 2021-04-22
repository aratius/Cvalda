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
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard
        
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
            float3 worldNormal;
            float3 viewDir;
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
            fixed4 baseColor = fixed4(0.05, 0.1, 0, 1);
            fixed4 rimColor = fixed4(1, 0.2, 0.2, 1);  // *** 回り込み後光の色

            o.Albedo = baseColor;
            float rim = 1 - saturate(dot(IN.viewDir, o.Normal));  // *** オブジェクト輪郭付近のEmissionを強くするための内積を取る
            o.Emission = rimColor * pow(rim, 2.5);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
