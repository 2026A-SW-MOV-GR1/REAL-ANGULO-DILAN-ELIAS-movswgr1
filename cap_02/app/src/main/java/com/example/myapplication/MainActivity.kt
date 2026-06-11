package com.example.myapplication

import android.content.Intent
import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import android.widget.Button
import android.net.Uri
import android.provider.ContactsContract
import android.util.Log
import androidx.activity.result.contract.ActivityResultContracts
    import com.example.myapplication.BEntrenador


class MainActivity : AppCompatActivity() {
    val callbackContenidoIntentImplicito =

        registerForActivityResult(
            ActivityResultContracts.StartActivityForResult()
        ){
                result ->
            if(result.resultCode == RESULT_OK){
                if(result.data != null){
                    var uri: Uri = result.data!!.data!!
                    val cursor = contentResolver.query(
                        uri,
                        null,
                        null,
                        null,
                        null,
                    )
                    cursor?.moveToFirst()
                    val indiceTelefono =cursor?.getColumnIndex(
                        ContactsContract.CommonDataKinds.Phone.NUMBER
                    )
                    val telefono =cursor?.getString(indiceTelefono!!)
                    cursor?.close()
                    Log.i("resultado", "Telefono: $telefono")
                }
            }
        }
    val callbackContenidoIntentExplicito =
        registerForActivityResult(
            ActivityResultContracts.StartActivityForResult()
        ){
                result ->
            if(result.resultCode == RESULT_OK){
                if(result.data != null){
                    val nombre = result.data!!.getStringExtra("nombre")
                    val apellido = result.data!!.getStringExtra("apellido")
                    val edad = result.data!!.getIntExtra("edad", 0)
                    Log.i("resultado", "$nombre $apellido $edad")
                }
            }
        }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
        val botonImplicito = findViewById<Button>(
            R.id.btn_ir_intent_implicito
        )
        botonImplicito.setOnClickListener {
            val intenConRespuesta = Intent(
                Intent.ACTION_PICK,
                ContactsContract.CommonDataKinds.
                Phone.CONTENT_URI
            )
            callbackContenidoIntentImplicito
                .launch(intenConRespuesta)

        }
        val botonExplicito = findViewById<Button>(
            R.id.btn_ir_intent_explicito
        )
        botonExplicito
            .setOnClickListener {
                val intentExplicito = Intent(
                    this,
                    CIntentExplicitoParametros::class.java
                )
                intentExplicito.putExtra("nombre", "Adrian")
                intentExplicito.putExtra("apellido", "Eguez")
                intentExplicito.putExtra("edad", 33)
                intentExplicito.putExtra("entrenador", BEntrenador(1, "Adrian", "Paleta"))

                callbackContenidoIntentExplicito.launch(intentExplicito)
    }
}
}