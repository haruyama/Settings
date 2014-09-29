#!/usr/bin/env ruby

require 'rexml/document'

def node(doc, level)
  doc.elements.each('node') do |element|

    nl = false
    if level < 1
      node(element, level + 1)
      next
    elsif level < 2
      print "\n"
      print '# '
      nl = true
    elsif level > 5
      next
    else
      print ' ' * ((level - 2) * 4)
      print '- '
    end

    text = element.attributes['TEXT']
    text = '!richcontext' unless text
    text = text.gsub(/\n/, '')
    puts text
    print "\n" if nl
    node(element, level + 1)
  end
end

file = File.new(ARGV[0])
doc = REXML::Document.new file

node(doc.elements['/map'], 0)
