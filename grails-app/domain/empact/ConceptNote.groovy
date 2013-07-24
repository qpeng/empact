package empact

class ConceptNote {

    String title
    String applications
    String abstractDescription
    String dataSources


    static constraints = {
        title(blank:false)
        applications(blank:false, maxSize:5000)
        abstractDescription(blank:false, maxSize:5000)
        dataSources(blank:false, maxSize:5000)
    }

    String toString() {
        title
        applications
        abstractDescription
        dataSources
    }
}