using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AbrirPuertas : MonoBehaviour
{
    public Transform puertaIzquierda;
    public Transform puertaDerecha;
    public float finalIzquierda = 2.278f;
    public float finalDerecha = -2.454f;
    public float speed = 0.125f;
    const float ini = -0.1431108f;
    public Vector3 vFinalDerecha;
    public Vector3 vFinalIzquierda;

    // Start is called before the first frame update
    void Start()
    {
        vFinalDerecha = new Vector3(puertaDerecha.localPosition.x, puertaDerecha.localPosition.y, finalDerecha);
        vFinalIzquierda = new Vector3(puertaIzquierda.localPosition.x, puertaIzquierda.localPosition.y, finalIzquierda);
    }

    // Update is called once per frame
    void Update()
    {
        puertaDerecha.localPosition = Vector3.Lerp(puertaDerecha.localPosition, vFinalDerecha, speed * Time.deltaTime);
        puertaIzquierda.localPosition = Vector3.Lerp(puertaIzquierda.localPosition, vFinalIzquierda, speed * Time.deltaTime);
    }
}
