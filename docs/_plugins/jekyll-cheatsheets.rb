module Jekyll
  module CheatSheets
    class CheatSheetTag < Liquid::Block


      def initialize(tag_name, text, tokens)
        super
        @text = text
      end

      def render(context)
        return "|Column1| Column2\n" \
        + "|Value1 | Value2"
        #'#{@text} #{Time.now} #{Time.now}}#{Time.now}'
      end

    end
  end
end

Liquid::Template.register_tag("cheatsheet", Jekyll::CheatSheets::CheatSheetTag)
