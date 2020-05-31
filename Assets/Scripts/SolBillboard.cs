using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SolBillboard : MonoBehaviour
{
    public Transform transCamara;

    // Update is called once per frame
    void Update()
    {
        transform.LookAt(transCamara);
        transform.rotation *= Quaternion.Euler(90, 0, 0);
    }
}
