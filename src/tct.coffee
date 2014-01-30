class TCT
    constructor: (element, options, settings) ->
        @element = $(element) or throw "element parameter needed"
        @options = options or []
        @settings = settings or {}
        @optionTpl = @settings.optionTpl or '<li>#{option}</li>'
        @tooltipTpl = @settings.tooltipTpl or '<ul>#{options}</ul>'
        @maxOptions = @settings.maxOptions or 10
        @minLength = @settings.minLength or 1
        @buffer = ""

        @element.on('keyup', @onKeyPress)

    fromEvent: (event) ->
        _to_ascii =
            '188': '44'
            '109': '45'
            '190': '46'
            '191': '47'
            '192': '96'
            '220': '92'
            '222': '39'
            '221': '93'
            '219': '91'
            '173': '45'
            '187': '61' # IE Key codes
            '186': '59' # IE Key codes
            '189': '45'  # IE Key codes

        shiftUps =
            "96": "~"
            "49": "!"
            "50": "@"
            "51": "#"
            "52": "$"
            "53": "%"
            "54": "^"
            "55": "&"
            "56": "*"
            "57": "("
            "48": ")"
            "45": "_"
            "61": "+"
            "91": "{"
            "93": "}"
            "92": "|"
            "59": ":"
            "39": "\""
            "44": "<"
            "46": ">"
            "47": "?"

        code = event.which
        if _to_ascii[code]?
            code = _to_ascii[code]

        if shiftUps[code]? and event.shiftKey
            char = shiftUps[code]
        else if event.shiftKey
            char = String.fromCharCode(code).toUpperCase()
        else
            char = String.fromCharCode(code).toLowerCase()

        return char

    onKeyPress: (event) =>
        charCode = @fromEvent(event)
        if charCode in [' ', '\t', '\n']
            @buffer = ""
        else if charCode in ['\b']
            if @buffer.length > 0
                @buffer = @buffer.substring(0, @buffer.length - 1)
        else
            @buffer += charCode

        if @buffer
            options = @getOptions(@buffer)
            if options.length > 0
                @showTooltip(options)

    getOptions: (text) ->
        if @minLength > text.length
            return []

        result = []
        for option in @options
            if option.key.substring(0, text.length) == text
                result.push(option)

            if result.length >= @maxOptions and @maxOptions != -1
                break

        return result

    showTooltip: (options) ->
        console.log options

@TCT = TCT
