package com.example.teste_flutter_kotlin.model

data class Register(
        var id: Int = 0,
        var name: String = "",
        var cpf: String = "",
        var cep: String = "",
        var address: String = "",
        var district: String = ""
)