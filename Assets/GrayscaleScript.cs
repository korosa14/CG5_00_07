using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Profiling;

public class GrayscaleScript : MonoBehaviour
{
    public Shader shader;
    private Material gaussianBlurMat;
    private Material material;

    private void Awake()
    {
        gaussianBlurMat = new Material(shader);//shaderを割り当てたマテリアルの動的生成
        material = new Material(shader);
    }

    //00_07
    //C#Script on Main Camera
    //private void OnRenderImage(
    //    RenderTexture source, RenderTexture destination)
    //{
    //    Graphics.Blit(source, destination, material);
    //}

    //00_08
    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, material);

        RenderTexture buf1 = 
            RenderTexture.GetTemporary(source.width / 2, source.height / 2, 0, source.format);

        RenderTexture buf2 =
            RenderTexture.GetTemporary(source.width / 4, source.height / 4, 0, source.format);

        RenderTexture buf3 =
            RenderTexture.GetTemporary(source.width / 8, source.height / 8, 0, source.format);

        RenderTexture blurTex = RenderTexture.GetTemporary(buf3.width, buf3.height, 0, buf3.format);

        Graphics.Blit(source, buf1);
        Graphics.Blit(buf1, buf2);
        Graphics.Blit(buf2, buf3);
        Graphics.Blit(buf3, blurTex, gaussianBlurMat);
        Graphics.Blit(blurTex, buf2);
        Graphics.Blit(buf2, buf1);
        Graphics.Blit(buf1, destination);

        RenderTexture.ReleaseTemporary(buf1);
        RenderTexture.ReleaseTemporary(buf2);
        RenderTexture.ReleaseTemporary(buf3);
        RenderTexture.ReleaseTemporary(blurTex);
    }

    // Start is called before the first frame update
    void Start()
    {
        Screen.SetResolution(1920, 1080, false);
    }

    // Update is called once per frame
    void Update()
    {

    }
}
