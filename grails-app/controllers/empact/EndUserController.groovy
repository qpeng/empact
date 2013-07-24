package empact

import org.springframework.dao.DataIntegrityViolationException

class EndUserController {

    // static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def login = {}

    def authenticate = {
        def user = EndUser.findByUserNameAndPassword(params.userName, params.password)

        if (user) {
            session.user = user
            flash.message = "Hello ${user.toString()}!"
            redirect(controller: "project", action: "list")

        } else {
            flash.message = "Sorry, ${params.userName}. Please try again."
            redirect(action: "login")
        }
    }

    def logout = {
        flash.message = "Goodbye ${session.user.toString()}"
        session.user = null
        redirect(action: "login")
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [endUserInstanceList: EndUser.list(params), endUserInstanceTotal: EndUser.count()]
    }

    def create() {
        [endUserInstance: new EndUser(params)]
    }

    def additionalInfo(Long id) {
        render(
                template: 'usertype',
                model: [
                        type: UserType.get(id).name
                ]
        )
    }

    def save() {

        def endUserInstance = new EndUser(params)

        if (!endUserInstance.save(flush: true)) {
            render(view: "create", model: [endUserInstance: endUserInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'endUser.label', default: 'EndUser'), endUserInstance.id])
        redirect(action: "show", id: endUserInstance.id)
    }

    def show(Long id) {

        def endUserInstance = EndUser.get(id)

        if (!endUserInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'endUser.label', default: 'EndUser'), id])
            redirect(action: "list")
            return
        }
        [endUserInstance: endUserInstance]
    }

    def edit(Long id) {
        def endUserInstance = EndUser.get(id)
        if (!endUserInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'endUser.label', default: 'EndUser'), id])
            redirect(action: "list")
            return
        }

        [endUserInstance: endUserInstance]
    }

    def update(Long id, Long version) {
        def endUserInstance = EndUser.get(id)
        if (!endUserInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'endUser.label', default: 'EndUser'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (endUserInstance.version > version) {
                endUserInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'endUser.label', default: 'EndUser')] as Object[],
                        "Another user has updated this EndUser while you were editing")
                render(view: "edit", model: [endUserInstance: endUserInstance])
                return
            }
        }

        endUserInstance.properties = params

        if (!endUserInstance.save(flush: true)) {
            render(view: "edit", model: [endUserInstance: endUserInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'endUser.label', default: 'EndUser'), endUserInstance.id])
        redirect(action: "show", id: endUserInstance.id)
    }

    def delete(Long id) {
        def endUserInstance = EndUser.get(id)


        if (!endUserInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'endUser.label', default: 'EndUser'), id])
            redirect(action: "list")
            return
        }

        try {
            endUserInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'endUser.label', default: 'EndUser'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'endUser.label', default: 'EndUser'), id])
            redirect(action: "show", id: id)
        }
    }

    def matchusers(Integer max) {

        params.max = Math.min(max ?: 10, 100)
        [endUserInstanceList: EndUser.list(params), endUserInstanceTotal: EndUser.count(), projectInstanceList: Project.list(params), projectInstanceTotal: Project.count()]
    }

    def userInfo(Long id) {
        def userInstance = EndUser.get(id);


        if (!userInstance) {
            return      // All we should do for now, more later
        }

        render(template: 'userInfo', userInstance: userInstance)
    }

    def upload() {
        // Session.evict()
        def userInstance = session.user

        def f = request.getFile('myFile')

        if (f.empty) {
            flash.message = 'file cannot be empty'
            render(view: 'uploadForm')
            return
        }
        def origname = f.getOriginalFilename()

        def ext
        int i = origname.lastIndexOf('.');
        if (i > 0) {
            ext = origname.substring(i+1);
        }

        f.transferTo(new File("web-app/images/${userInstance.userName}-avatar.${ext}"))

        userInstance.avatarType = f.getContentType()
        userInstance.setAvataraddress("${userInstance.userName}-avatar.${ext}")
        userInstance.save()

        redirect(action: "show", id: userInstance.id)
        //${userInstance.userName}-avatar.${arr[ind]}

    }

    def displayImage(){
        def userInstance = session.user
        def something = resource(dir: 'images', file: "${userInstance.avataraddress}")
        response.contentType = "${userInstance.avatarType}"
        response.outputStream << something
        response.outputStream.flush()
    }

}
