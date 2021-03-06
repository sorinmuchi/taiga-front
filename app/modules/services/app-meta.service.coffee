taiga = @.taiga

truncate = taiga.truncate


class AppMetaService extends taiga.Service = ->
    _set: (key, value) ->
        return if not key

        if key == "title"
            meta = $("title")

            if meta.length == 0
                meta = $("<title></title>")
                $("head").append(meta)

            meta.text(value or "")
        if key.indexOf("og:") == 0
            meta = $("meta[property='#{key}']")

            if meta.length == 0
                meta = $("<meta property='#{key}'/>")
                $("head").append(meta)

            meta.attr("content", value or "")
        else
            meta = $("meta[name='#{key}']")

            if meta.length == 0
                meta = $("<meta name='#{key}'/>")
                $("head").append(meta)

            meta.attr("content", value or "")

    setTitle: (title) ->
        @._set('title', title)

    setDescription: (description) ->
        @._set("description", truncate(description, 250))

    setTwitterMetas: (title, description) ->
        @._set("twitter:card", "summary")
        @._set("twitter:site", "@taigaio")
        @._set("twitter:title", title)
        @._set("twitter:description", truncate(description, 250))
        @._set("twitter:image", "#{window.location.origin}/images/favicon.png")

    setOpenGraphMetas: (title, description) ->
        @._set("og:type", "object")
        @._set("og:site_name", "Taiga - Love your projects")
        @._set("og:title", title)
        @._set("og:description", truncate(description, 250))
        @._set("og:image", "#{window.location.origin}/images/favicon.png")
        @._set("og:url", window.location.href)

    setAll: (title, description) ->
        @.setTitle(title)
        @.setDescription(description)
        @.setTwitterMetas(title, description)
        @.setOpenGraphMetas(title, description)


angular.module("taigaCommon").service("tgAppMetaService", AppMetaService)
