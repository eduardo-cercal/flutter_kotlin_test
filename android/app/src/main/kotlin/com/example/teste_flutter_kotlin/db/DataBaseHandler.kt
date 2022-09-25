package com.example.teste_flutter_kotlin.db

import android.content.ContentValues
import android.content.Context
import android.database.sqlite.SQLiteDatabase
import android.database.sqlite.SQLiteOpenHelper
import com.example.teste_flutter_kotlin.model.Register


class DataBaseHandler(context: Context) : SQLiteOpenHelper(context, DB_NAME, null, DB_VERSION) {
    override fun onCreate(db: SQLiteDatabase?) {
        val CREATE_TABLE =
                "create table $TABLE_NAME ($ID integer primary key, $NAME text, $CPF text, $CEP text, $ADDRESS text, $DISTRICT text);"

        db?.execSQL(CREATE_TABLE)
    }

    override fun onUpgrade(db: SQLiteDatabase?, oldVersion: Int, newVersion: Int) {
        val DROP_TABLE = "DROP TABLE IF EXISTS $TABLE_NAME"
        db?.execSQL(DROP_TABLE)
        onCreate(db)
    }

    fun addRegister(register: Register): Boolean {
        val db = this.writableDatabase
        val values = ContentValues()
        values.put(NAME, register.name)
        val _success = db.insert(TABLE_NAME, null, values)
        return (("$_success").toInt() != -1)
    }

    fun getRegister(_cpf: String): Register {
        val register = Register()
        val db = writableDatabase
        val selectQuery = "select * from $TABLE_NAME where $CPF = '$_cpf'"
        val cursor = db.rawQuery(selectQuery, null)
        cursor?.moveToFirst()
        register.id = cursor.getInt(cursor.getColumnIndexOrThrow(ID))
        register.name = cursor.getString(cursor.getColumnIndexOrThrow(NAME))
        cursor.close()

        return register
    }

    fun getListRegister(): ArrayList<Register> {
        val registerList = ArrayList<Register>()
        val db = writableDatabase
        val selectQuery = "SELECT * FROM $TABLE_NAME"
        val cursor = db.rawQuery(selectQuery, null)
        if (cursor != null) {
            if (cursor.moveToFirst()) {
                do {
                    val register = Register()
                    register.id = cursor.getInt(cursor.getColumnIndexOrThrow(ID))
                    register.name = cursor.getString(cursor.getColumnIndexOrThrow(NAME))
                    register.cpf = cursor.getString(cursor.getColumnIndexOrThrow(CPF))
                    register.cep = cursor.getString(cursor.getColumnIndexOrThrow(CEP))
                    register.address = cursor.getString(cursor.getColumnIndexOrThrow(ADDRESS))
                    register.district = cursor.getString(cursor.getColumnIndexOrThrow(DISTRICT))
                    registerList.add(register)
                } while (cursor.moveToNext())
            }
        }
        cursor.close()
        return registerList
    }

    companion object {
        private val DB_VERSION = 1
        private val DB_NAME = "Cadastro"
        private val TABLE_NAME = "Registro"
        private val ID = "id"
        private val NAME = "name"
        private val CPF = "cpf"
        private val CEP = "cep"
        private val ADDRESS = "address"
        private val DISTRICT = "district"
    }
}