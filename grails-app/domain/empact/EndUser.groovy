package empact

class EndUser {
    String userName
    String password
    String institution
    String securityQuestion
    String securityAnswer
    String email
    String firstName
    String lastName
    String address
    String avataraddress
    String avatarType
    Integer phone
    UserType userType
    Country country
    WhoOffice whoOffice
    String toString () {
        "${firstName + ' ' + lastName}"
    }

    static hasMany = [
            languages: Language,
            interests: String,
            skills: String
    ]

    static constraints = {
        address(nullable:true)
        phone(nullable:true)
        institution(nullable: true)
        securityAnswer(nullable: true)
        securityQuestion(nullable: true)
        email(nullable: true)
        firstName(blank: false)
        lastName(blank: false)
        userName(blank: false)
        password(password:true)
        languages(nullable: true)
        userType(nullable: true)
        interests(nullable: true)
        skills(nullable: true)
        country(blank: false)
        whoOffice(nullable: true)
        avataraddress(nullable: true)
        avatarType(nullable: true)

    }
}
