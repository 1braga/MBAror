class HtmlBuilder
    def initialize(&block)
        @html = ""
        instance_eval(&block) if block_given?
    end

    def div(content = nil, &block)
        @html << "<div>"
        if block_given?
            instance_eval(&block)
        else
            @html << content.to_s
        end
        @html << "</div>\n"
    end

    def span(content = nil, &block)
        @html << "<span>"
        if block_given?
            instance_eval(&block)
        else
            @html << content.to_s
        end
        @html << "</span>\n"
    end

    def result
        @html
    end
end

builder = HtmlBuilder.new do
    div do
        div "Conteúdo em div"
        span "Nota em div"
    end
    span "Nota de rodapé"
end

puts builder.result
