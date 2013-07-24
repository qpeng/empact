package empact

import org.springframework.dao.DataIntegrityViolationException

class ProjectRequestController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [projectRequestInstanceList: ProjectRequest.list(params), projectRequestInstanceTotal: ProjectRequest.count()]
    }

    def create() {
        [projectRequestInstance: new ProjectRequest(params)]
    }

    def save() {
        def projectRequestInstance = new ProjectRequest(params)
        if (!projectRequestInstance.save(flush: true)) {
            render(view: "create", model: [projectRequestInstance: projectRequestInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'projectRequest.label', default: 'ProjectRequest'), projectRequestInstance.id])
        redirect(action: "show", id: projectRequestInstance.id)
    }

    def show(Long id) {
        def projectRequestInstance = ProjectRequest.get(id)
        if (!projectRequestInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'projectRequest.label', default: 'ProjectRequest'), id])
            redirect(action: "list")
            return
        }

        [projectRequestInstance: projectRequestInstance]
    }

    def edit(Long id) {
        def projectRequestInstance = ProjectRequest.get(id)
        if (!projectRequestInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'projectRequest.label', default: 'ProjectRequest'), id])
            redirect(action: "list")
            return
        }

        [projectRequestInstance: projectRequestInstance]
    }

    def update(Long id, Long version) {
        def projectRequestInstance = ProjectRequest.get(id)
        if (!projectRequestInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'projectRequest.label', default: 'ProjectRequest'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (projectRequestInstance.version > version) {
                projectRequestInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'projectRequest.label', default: 'ProjectRequest')] as Object[],
                        "Another user has updated this ProjectRequest while you were editing")
                render(view: "edit", model: [projectRequestInstance: projectRequestInstance])
                return
            }
        }

        projectRequestInstance.properties = params

        if (!projectRequestInstance.save(flush: true)) {
            render(view: "edit", model: [projectRequestInstance: projectRequestInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'projectRequest.label', default: 'ProjectRequest'), projectRequestInstance.id])
        redirect(action: "show", id: projectRequestInstance.id)
    }

    def delete(Long id) {
        def projectRequestInstance = ProjectRequest.get(id)
        if (!projectRequestInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'projectRequest.label', default: 'ProjectRequest'), id])
            redirect(action: "list")
            return
        }

        try {
            projectRequestInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'projectRequest.label', default: 'ProjectRequest'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'projectRequest.label', default: 'ProjectRequest'), id])
            redirect(action: "show", id: id)
        }
    }
}
