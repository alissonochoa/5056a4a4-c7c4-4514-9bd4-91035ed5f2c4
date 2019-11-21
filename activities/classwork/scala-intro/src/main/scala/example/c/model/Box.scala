package example.c.model

case class Box[A](value: A) {

  def show(): Unit = println(value)

  def map[B](fn: A => B): Box[B] = Box(fn(value))

  def flatMap[B](fn: A => Box[B]): Box[B] = fn(value)

  def concat(other: Box[A]): Box[String] =
    Box(value.toString + other.value.toString)


}
