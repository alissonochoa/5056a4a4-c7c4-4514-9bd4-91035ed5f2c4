package example.a

import example.a.model.Timestamp // se puede poner solo model.Timestamp

object Main {
  def main(args:Array[String]): Unit = { // unit = nada
    val Array (s1, s2) = args //s1 y s2 = string

    val t1 = Timestamp(seconds = s1.toInt) // toInt para convertir un entero
    val t2 = Timestamp(seconds = s2.toInt)

    println(t1 + t2)
  }
}
