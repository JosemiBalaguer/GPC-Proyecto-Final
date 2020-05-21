using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SistemaSolar : MonoBehaviour
{
    public bool orbit = false;
    public bool translate = false;

    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void FixedUpdate()
    {
        if (orbit)
            transform.RotateAround(transform.parent.position, transform.up, 30 * Time.fixedDeltaTime);
        if (translate)
            transform.Translate(transform.up * Time.fixedDeltaTime * 3);
    }
}
