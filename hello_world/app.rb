require 'thinreports'
require 'json'
require 'base64'

def lambda_handler(event:, context:)
  # あとでS3から読むようにしようね
  File.open("/tmp/gorilla.tlf", "w") do |f|
    f.puts layout
  end

  report = Thinreports::Report.new layout: '/tmp/gorilla.tlf'

  report.start_new_page do |page|
    page.item(:say).value('ウホホイ')
  end

  return {
    :statusCode => 200,
    :isBase64Encoded => true,
    :headers => { 'Content-Type': 'application/pdf' },
    :body => Base64.encode64(report.generate)
  }
end

def layout
lines =<<EOS
{
  "version": "0.10.0",
  "items": [
    {
      "id": "title",
      "type": "text",
      "display": true,
      "description": "",
      "x": 84.1,
      "y": 63,
      "width": 200,
      "height": 33,
      "style": {
        "font-family": [
          "Helvetica"
        ],
        "font-size": 18,
        "color": "#000000",
        "text-align": "left",
        "vertical-align": "top",
        "line-height": "",
        "line-height-ratio": "",
        "letter-spacing": "",
        "font-style": []
      },
      "texts": [
        "ゴリラ"
      ]
    },
    {
      "id": "say",
      "type": "text-block",
      "display": true,
      "description": "",
      "x": 96.1,
      "y": 104,
      "width": 182,
      "height": 20.5,
      "style": {
        "font-family": [
          "Helvetica"
        ],
        "font-size": 18,
        "color": "#000000",
        "text-align": "left",
        "vertical-align": "top",
        "line-height": "",
        "line-height-ratio": "",
        "letter-spacing": "",
        "font-style": [],
        "overflow": "truncate",
        "word-wrap": "break-word"
      },
      "reference-id": "",
      "value": "",
      "multiple-line": false,
      "format": {
        "base": "",
        "type": ""
      }
    }
  ],
  "state": {
    "layout-guides": []
  },
  "title": "sample",
  "report": {
    "paper-type": "A4",
    "orientation": "portrait",
    "margin": [
      20,
      20,
      20,
      20
    ]
  }
}
EOS
lines
end  
