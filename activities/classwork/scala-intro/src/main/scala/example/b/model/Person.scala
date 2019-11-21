package example.b.model

case class Person(FirstName: String, LastName: String, gender: String){

  def greeting(other: Person): String = other.gender match { //gender = atributo del objeto en sí
    case Person.Gender.male => s"Guten tag, herr ${other.LastName}" //Gender = atributo del Gender de abajo
    case Person.Gender.female => s"Guten tag, frau ${other.LastName}"
    case _ => "Guten tag, herr"
  }
}


object Person {
  object Gender{
    val male = "male"
    val female = "female"
    val undefined = "undefined"

  }
}


