package com.example.myapplication

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.example.myapplication.BEntrenador
import com.example.myapplication.R

class CIntentExplicitoParametros : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_cliente_explicito_parametros)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
        val entrenador = intent.getParcelableExtra<BEntrenador>(
            "entrenador"
        )
        val tvId = findViewById<TextView>(R.id.tvId)
        val tvNombre = findViewById<TextView>(R.id.tvNombre)
        val tvDescripcion = findViewById<TextView>(R.id.tvDescripcion)
        tvId.text = entrenador?.id.toString()
        tvNombre.text = entrenador?.nombre
        tvDescripcion.text = entrenador?.descripcion


        val nombre = intent.getStringExtra("nombre")
        val apellido = intent.getStringExtra("apellido")
        val edad = intent.getIntExtra("edad", 0)

        val botonDevolverRespuesta = findViewById<Button>(
            R.id.btn_devolver_respuesta
        )
        botonDevolverRespuesta.setOnClickListener {
            val intentDevolverParametros = Intent()
            intentDevolverParametros.putExtra(
                "nombreModificado",
                nombre + apellido + edad.toString() + " :) "
            )
            setResult(RESULT_OK, intentDevolverParametros)
            finish()
        }
    }
}