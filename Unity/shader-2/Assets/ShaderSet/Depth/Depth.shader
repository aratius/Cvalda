Shader "Custom/Depth"
{
    // Depth buffer のみで Color buffer には書き込まない
    Properties {
        _Color ("Color", Color) = (1,1,1,1)
    }

    SubShader {
        Tags {"Queue" = "Geometry-1"}

        Pass{
            Zwrite On
            ColorMask 0
        }
    }
}
