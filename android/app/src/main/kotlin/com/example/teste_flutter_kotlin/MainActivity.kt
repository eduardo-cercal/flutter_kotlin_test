package com.example.teste_flutter_kotlin

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.example.teste_flutter_kotlin.db.DataBaseHandler
import com.example.teste_flutter_kotlin.model.Register
import java.io.InputStreamReader
import java.net.URL


class MainActivity : FlutterActivity() {
    private val channel = "example.com/kotlinTest"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler { call, result ->

            if (call.method == "initDb") {
                // SQLite
                var databaseHandler = DataBaseHandler(this)
            }

            if (call.method == "getList") {
                var databaseHandler = DataBaseHandler(this)
                var queryResult = databaseHandler.getListRegister()
                var flutterResult = ArrayList<Map<String, Any>>()
                queryResult.forEach {
                    val map = mapOf("name" to it.name, "cpf" to it.cpf, "district" to it.district, "cep" to it.cep, "address" to it.address, "expanded" to false)
                    flutterResult.add(map)
                }


                result.success(flutterResult)
            }

            if (call.method == "existRegister") {
                var databaseHandler = DataBaseHandler(this)
                val cpf = call.argument<String>("cpf")!!
                val queryResult = databaseHandler.getRegister(cpf)
                val flutterResult = mapOf("id" to queryResult.id, "name" to queryResult.name)

                result.success(flutterResult)
            }

            if (call.method == "insertRegister") {
                var databaseHandler = DataBaseHandler(this)
                val register = Register()
                register.name = call.argument<String>("name")!!
                register.cpf = call.argument<String>("cpf")!!
                register.cep = call.argument<String>("cep")!!
                register.district = call.argument<String>("district")!!
                register.address = call.argument<String>("address")!!

                result.success(databaseHandler.addRegister(register))
            }

        }
    }
}
