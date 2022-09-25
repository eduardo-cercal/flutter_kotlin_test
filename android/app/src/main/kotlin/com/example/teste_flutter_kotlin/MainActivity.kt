package com.example.teste_flutter_kotlin

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.example.teste_flutter_kotlin.db.DataBaseHandler
import com.example.teste_flutter_kotlin.model.Register


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

                result.success(databaseHandler.getListRegister())
            }

            if (call.method == "existRegister") {
                var databaseHandler = DataBaseHandler(this)
                val args = call.arguments() as String?

                result.success("databaseHandler.getRegister")
            }

            if (call.method == "searchAddress") {

            }

            if (call.method == "insertRegister") {
                var databaseHandler = DataBaseHandler(this)

            }

        }
    }
}
