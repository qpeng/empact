package empact

class ProjectRequest {

    EndUser owner
    Date sent
    Boolean approved
    String details

    static constraints = {
        sent()
        approved()
        details(blank:false, maxSize:5000)
    }

    static belongsTo = [
            project:Project
    ]

    String toString() {
        details
    }
}
