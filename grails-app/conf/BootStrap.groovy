import empact.ConceptNote
import empact.Country
import empact.EndUser
import empact.Language
import empact.UserType
import empact.WhoOffice

class BootStrap {

    def init = { servletContext ->

        def africa = [
                'Algeria', 'Angola', 'Benin', 'Botswana', 'Burkina Faso', 'Burundi',
                'Cameroon', 'Cape Verde', 'Central African Republic', 'Chad', 'Comoros',
                'Congo', "Côte d'Ivoire", 'Democratic Republic of the Congo', 'Equatorial Guinea',
                'Eritrea', 'Ethiopia', 'Gabon', 'Gambia', 'Ghana', 'Guinea', 'Guinea-Bissau', 'Kenya',
                'Lesotho', 'Liberia', 'Madagascar', 'Malawi', 'Mali', 'Mauritania', 'Mauritius',
                'Mozambique', 'Namibia', 'Niger', 'Nigeria', 'Rwanda', 'Sao Tome and Principe',
                'Senegal', 'Seychelles', 'Sierra Leone', 'South Africa', 'Swaziland', 'Togo',
                'Uganda', 'United Republic of Tanzania', 'Zambia', 'Zimbabwe'
        ]

        def america = [
                'Antigua and Barbuda', 'Argentina', 'Bahamas', 'Barbados', 'Belize', 'Bolivia (Plurinational State of)',
                'Brazil', 'Canada', 'Chile', 'Colombia', 'Costa Rica', 'Cuba', 'Dominica',
                'Dominican Republic', 'Ecuador', 'El Salvador', 'Grenada', 'Guatemala', 'Guyana',
                'Haiti', 'Honduras', 'Jamaica', 'Mexico', 'Nicaragua', 'Panama', 'Paraguay',
                'Peru', 'Saint Kitts and Nevis', 'Saint Lucia', 'Saint Vincent and the Grenadines',
                'Suriname', 'Trinidad and Tobago', 'United States of America', 'Uruguay',
                'Venezuela (Bolivarian Republic of)'
        ]

        def sea = [
                'Bangladesh', 'Bhutan', "Democratic People's Republic of Korea", 'India',
                'Indonesia', 'Maldives', 'Myanmar', 'Nepal', 'Sri Lanka', 'Thailand', 'Timor-Leste'
        ]

        def europe = [
                'Albania', 'Andorra', 'Armenia', 'Austria', 'Azerbaijan', 'Belarus', 'Belgium',
                'Bosnia and Herzegovina', 'Bulgaria', 'Croatia', 'Cyprus', 'Czech Republic', 'Denmark',
                'Estonia', 'Finland', 'France', 'Georgia', 'Germany', 'Greece', 'Hungary', 'Iceland', 'Ireland',
                'Israel', 'Italy', 'Kazakhstan', 'Kyrgyzstan', 'Latvia', 'Lithuania', 'Luxembourg', 'Malta',
                'Monaco', 'Montenegro', 'Netherlands', 'Norway', 'Poland', 'Portugal', 'Republic of Moldova',
                'Romania', 'Russian Federation', 'San Marino', 'Serbia', 'Slovakia', 'Slovenia', 'Spain',
                'Sweden', 'Switzerland', 'Tajikistan', 'The former Yugoslav Republic of Macedonia', 'Turkey',
                'Turkmenistan', 'Ukraine', 'United Kingdom', 'Uzbekistan'
        ]

        def medit = [
                'Afghanistan', 'Bahrain', 'Djibouti', 'Egypt', 'Iran (Islamic Republic of)', 'Iraq', 'Jordan',
                'Kuwait', 'Lebanon', 'Libya', 'Morocco', 'Oman', 'Pakistan', 'Qatar', 'Saudi Arabia', 'Somalia',
                'South Sudan', 'Sudan', 'Syrian Arab Republic', 'Tunisia', 'United Arab Emirates', 'Yemen'
        ]

        def pacific = [
                'Australia', 'Brunei Darussalam', 'Cambodia', 'China', 'Cook Islands', 'Fiji', 'Japan',
                'Kiribati', "Lao People's Democratic Republic", 'Malaysia', 'Marshall Islands',
                'Micronesia (Federated States of)', 'Mongolia', 'Nauru', 'New Zealand', 'Niue', 'Palau',
                'Papua New Guinea', 'Philippines', 'Republic of Korea', 'Samoa', 'Singapore', 'Solomon Islands',
                'Tonga', 'Tuvalu', 'Vanuatu', 'Viet Nam'
        ]

        def languages = [
                'Arabic', 'Chinese', 'English', 'French', 'Russian', 'Spanish'
        ]

        def userType = [
                'Student Analyst', 'Expert', 'Mentor', 'WHO Official', 'Country Official', 'NGO Official', 'Moderator', 'Superuser'
        ]

        if (!UserType.count()) {
            for (String type : userType) {
                new UserType(
                        name: type
                ).save()
            }
        }

        if (!Language.count()) {
            for (String lang : languages) {
                new Language(
                        name: lang
                ).save()
            }
        }

        if (!WhoOffice.count()) {
            def co = new WhoOffice()
            co.setName("Country Office")
            co.save()

            def hq = new WhoOffice()
            hq.setName("Global Headquarters")
            hq.save()


            def rofa = new WhoOffice()
            rofa.setName("Regional Office for Africa")

            for (String name : africa) {
                Country country = new Country()
                country.setName(name)
                country.save()

                rofa.addToCountries(country)
            }
            rofa.save(failOnError: true)

            def rofta = new WhoOffice()
            rofta.setName("Regional Office for the Americas")

            for (String name : america) {
                Country country = new Country()
                country.setName(name)
                country.save()

                rofta.addToCountries(country)
            }
            rofta.save(failOnError: true)

            def rofsea = new WhoOffice()
            rofsea.setName("Regional Office for South-East Asia")

            for (String name : sea) {
                Country country = new Country()
                country.setName(name)
                country.save()

                rofsea.addToCountries(country)
            }
            rofsea.save(failOnError: true)

            def rofe = new WhoOffice()
            rofe.setName("Regional Office for Europe")

            for (String name : europe) {
                Country country = new Country()
                country.setName(name)
                country.save()

                rofe.addToCountries(country)
            }
            rofe.save(failOnError: true)

            def rofem = new WhoOffice()
            rofem.setName("Regional Office for Eastern Meditarranean")

            for (String name : medit) {
                Country country = new Country()
                country.setName(name)
                country.save()

                rofem.addToCountries(country)
            }
            rofem.save(failOnError: true)

            def roftwp = new WhoOffice()
            roftwp.setName("Regional Office for the Western Pacific")

            for (String name : pacific) {
                Country country = new Country()
                country.setName(name)
                country.save()

                roftwp.addToCountries(country)
            }

            roftwp.save(failOnError: true)
        }

        if (!EndUser.count()) {

            //Student Analyst
            def sngobese = new EndUser(
                    version: 0,
                    address: '1600 Grand Avenue, St Paul, MN',
                    email: 'sngobese@macalester.edu',
                    firstName: 'Sibusiso',
                    institution: 'Macalester College',
                    lastName: 'Ngobese',
                    password: 'password',
                    securityAnswer: 'asasdfasdf',
                    securityQuestion: 'seasdzsdvf',
                    userName: 'sngobese'
            )
            sngobese.setUserType(UserType.findByName('Student Analyst'))
            sngobese.setCountry(Country.get(168))
            sngobese.addToLanguages(Language.get(1))
            sngobese.addToLanguages(Language.get(4))
            sngobese.addToLanguages(Language.get(6))

            sngobese.save(failOnError: true)

            //Mentor
            def iali1 = new EndUser(
                    version: 0,
                    address: '1600 Grand Avenue, St Paul, MN',
                    email: 'iali1@macalester.edu',
                    firstName: 'Issa',
                    institution: 'Macalester College',
                    lastName: 'Ali',
                    password: 'password',
                    securityAnswer: 'asasdfasdf',
                    securityQuestion: 'seasdzsdvf',
                    userName: 'iali1'
            )
            iali1.setUserType(UserType.findByName('Mentor'))
            iali1.setCountry(Country.get(78))
            iali1.save(failOnError: true)

            //Expert
            def mgiesel = new EndUser(
                    version: 0,
                    address: '1600 Grand Avenue, St Paul, MN',
                    email: 'mgiesel@macalester.edu',
                    firstName: 'Margaret',
                    institution: 'Macalester College',
                    lastName: 'Giesel',
                    password: 'password',
                    securityAnswer: 'asasdfasdf',
                    securityQuestion: 'seasdzsdvf',
                    userName: 'mgiesel'
            )
            mgiesel.setUserType(UserType.findByName('Expert'))
            mgiesel.setCountry(Country.get(25))
            mgiesel.save(failOnError: true)

            //NGO Official
            def zwang = new EndUser(
                    version: 0,
                    address: '1600 Grand Avenue, St Paul, MN',
                    email: 'zwang@macalester.edu',
                    firstName: 'Zixiao',
                    institution: 'Macalester College',
                    lastName: 'Wang',
                    password: 'password',
                    securityAnswer: 'asasdfasdf',
                    securityQuestion: 'seasdzsdvf',
                    userName: 'zwang'
            )
            zwang.setUserType(UserType.findByName('NGO Official'))
            zwang.setCountry(Country.get(176))
            zwang.save(failOnError: true)

            //Country Official
            def snaden = new EndUser(
                    version: 0,
                    address: '1600 Grand Avenue, St Paul, MN',
                    email: 'snaden@macalester.edu',
                    firstName: 'Sam',
                    institution: 'Macalester College',
                    lastName: 'Naden',
                    password: 'password',
                    securityAnswer: 'asasdfasdf',
                    securityQuestion: 'seasdzsdvf',
                    userName: 'snaden'
            )
            snaden.setUserType(UserType.findByName('Country Official'))
            snaden.setCountry(Country.get(47))
            snaden.save(failOnError: true)

            //WHO Official - Country
            def anichols1 = new EndUser(
                    version: 0,
                    address: '1600 Grand Avenue, St Paul, MN',
                    email: 'anichols1@macalester.edu',
                    firstName: 'Annabelle',
                    institution: 'Macalester College',
                    lastName: 'Nichols',
                    password: 'password',
                    securityAnswer: 'asasdfasdf',
                    securityQuestion: 'seasdzsdvf',
                    userName: 'anichols1'
            )
            anichols1.setUserType(UserType.findByName('WHO Official'))
            anichols1.setCountry(Country.get(46))
            anichols1.setWhoOffice(WhoOffice.findByName('Country Office'))
            anichols1.save(failOnError: true)

            //WHO Official - Region
            def bhillman = new EndUser(
                    version: 0,
                    address: '1600 Grand Avenue, St Paul, MN',
                    email: 'bhillman@macalester.edu',
                    firstName: 'Ben',
                    institution: 'Macalester College',
                    lastName: 'Hillmann',
                    password: 'password',
                    securityAnswer: 'asasdfasdf',
                    securityQuestion: 'seasdzsdvf',
                    userName: 'bhillman'
            )
            bhillman.setUserType(UserType.findByName('WHO Official'))
            bhillman.setCountry(Country.get(129))
            bhillman.setWhoOffice(WhoOffice.findByName('Regional Office for Africa'))
            bhillman.save(failOnError: true)

            //WHO Official - Global HQ
            def imarinci = new EndUser(
                    version: 0,
                    address: '1600 Grand Avenue, St Paul, MN',
                    email: 'imarinci@macalester.edu',
                    firstName: 'Ivana',
                    institution: 'Macalester College',
                    lastName: 'Marincic',
                    password: 'password',
                    securityAnswer: 'asasdfasdf',
                    securityQuestion: 'seasdzsdvf',
                    userName: 'imarinci'
            )
            imarinci.setUserType(UserType.findByName('WHO Official'))
            imarinci.setCountry(Country.get(116))
            imarinci.setWhoOffice(WhoOffice.findByName('Global Headquarters'))
            imarinci.save(failOnError: true)

            //Moderator
            def price = new EndUser(
                    version: 0,
                    address: '1600 Grand Avenue, St Paul, MN',
                    email: 'price@macalester.edu',
                    firstName: 'Paul',
                    institution: 'Macalester College',
                    lastName: 'Rice',
                    password: 'password',
                    securityAnswer: 'asasdfasdf',
                    securityQuestion: 'seasdzsdvf',
                    userName: 'price'
            )
            price.setUserType(UserType.findByName('Moderator'))
            price.setCountry(Country.get(2))
            price.save(failOnError: true)
        }

        if (!ConceptNote.count()) {
            new ConceptNote(
                    version: 0,
                    title: 'Concept Note One',
                    applications: 'Saving the world.',
                    abstractDescription: 'All of the world.',
                    dataSources: 'Wikipedia'
            ).save(failOnError: true)
        }


    }
    def destroy = {
    }
}
