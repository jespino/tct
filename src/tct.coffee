class TCT
    constructor: (element, options, settings) ->
        @element = element
        @options = options or []
        @settings = settings or {}
        @optionTpl = settings.optionTpl or '<li>#{option}</li>'
        @tooltipTpl = settings.tooltipTpl or '<ul>#{options}</ul>'
        @maxOptions = settings.maxOptions or 10
        @buffer = ""
        @element.click(@onKeyPress)

    onKeyPress: (event) ->
        console.log "HOLA"
        if event.key == '\s'
            buffer = ""
        else
            buffer += event.key

        if buffer
            options = @getOptions(buffer)
            if options.lengt > 0
                @showTooltip(options)

    getOptions: (text) ->
        result = []
        for option in @options
            if option.key.substring(text.length) == text
                result.append(option)

            if result.length > @maxOptions and @maxOptions != -1
                break

    showTooltip: (options) ->
        console.log options

@TCT = TCT
