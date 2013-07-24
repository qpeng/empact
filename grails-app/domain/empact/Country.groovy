package empact

class Country {

    String name

    static constraints = {
        name(unique: true)
    }

    static belongsTo = [ whoOffice: WhoOffice ]

    String toString() {
        name
    }
}
