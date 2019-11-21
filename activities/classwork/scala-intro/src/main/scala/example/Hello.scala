package example

object Hello { //necesito definir un metodo especial
  val default = "World"

  // Greeting function
  // run with sbt "runMain example.Hello World"
  def greeting(name: String = default): String = {  // expresion
    s"Hello, $name!"   // es lo que va a regresar porque es lo ultimo
  }

  //Main method
  def main(args: Array[String]): Unit = {
    val name = args.headOption.getOrElse(default)
    println(greeting(name))
  }
}