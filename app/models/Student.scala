package models

import play.api.db._
import play.api.Play.current
import anorm._
import anorm.SqlParser._

case class Student(
  id: Pk[Long],
  cardId: String,
  name: String,
  age: Option[Int],
  gender: Int,
  avatar: Option[String]) {
  
  var parents: List[Parent] = Nil
}

object Student {

  val TABLE_NAME = "student"

  val sample = {
    get[Pk[Long]]("id") ~
      get[String]("card_id") ~
      get[String]("name") ~
      get[Option[Int]]("age") ~
      get[Int]("gender") ~
      get[Option[String]]("avatar") map {
        case id ~ cardId ~ name ~ age ~ gender ~ avatar => Student(id, cardId, name, age, gender, avatar)
      }
  }

  def all(): List[Student] = DB.withConnection { implicit connection =>
    SQL("select * from student").as(Student.sample *)
  }

  def findByCardId(cardId: String): (Option[Student], List[Parent]) = DB.withConnection { implicit connection =>
    val studentOpt = SQL("select * from student where card_id={cardId}").on('cardId -> cardId).as(Student.sample.singleOpt)

    val parents = studentOpt match {
      case Some(student) => {
        SQL("select * from parent where student={studentId}").on('studentId -> student.id).as(Parent.sample *)
      }

      case None => List[Parent]()
    }
    (studentOpt, parents)
  }

  def create(cardId: String, name: String, age: Int, gender: Int, avatar: Option[String]) = DB.withConnection { implicit connection =>
    SQL(
      """
      insert into student(card_id, name, age, gender, avatar) values (
        {cardId}, {name}, {age}, {gender}, {avatar}
        )
      """
    ).on(
        'cardId -> cardId,
        'name -> name,
        'age -> age,
        'gender -> gender,
        'avatar -> avatar
      ).executeInsert(Student.sample.singleOpt)
  }

}