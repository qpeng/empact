package empact

class ConceptNote {

    String title
    String details


    static constraints = {
        title(blank:false)
        details(blank:false, maxSize:5000)
    }

    String toString() {
        title
        details
    }
}
