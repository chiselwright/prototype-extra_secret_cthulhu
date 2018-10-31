require 'game_icons'

deck = Squib.csv file: 'data/extra-secret-cthulhu.csv' # no artwork data in our game data!!

Squib::Deck.new(cards: deck['Title'].size, layout: %w(failure-deck.yml)) do
  background color: 'white'

  rect layout: :TitleBox, fill_color: :deep_sky_blue, stroke_width: 0
  rect fill_color: :black,   layout: :middle_rect
  rect fill_color: :red,   layout: :TypeBox, stroke_width: 0

  # things in white
  %w(Type).each do |key|
    text str: deck[key], color: :white, layout: key
  end

  # things in black
  %w(Title RuleTop RuleBottom).each do |key|
    text str: deck[key], color: :black, layout: key
  end

  #save_png prefix: 'even_bigger_'
  showcase file: 'showcase.png', fill_color: '#0000'
  #hand file: 'hand.png', trim: 37.5, trim_radius: 25, fill_color: '#0000', range: [0,2,4,6,7]

  save_pdf file: 'failure-deck-a4-landscape.pdf',
            height: "8.27in", width: "11.69in", 
            margin: 75, gap: 5, trim: 37

  showcase trim: 32, trim_radius: 32, margin: 100, face: :right,
           scale: 0.85, offset: 0.95, fill_color: :black,
           reflect_offset: 25, reflect_strength: 0.1, reflect_percent: 0.4,
           file: 'showcase1.png',
           range: 0..4
  showcase trim: 32, trim_radius: 32, margin: 100, face: :right,
           scale: 0.85, offset: 0.95, fill_color: :black,
           reflect_offset: 25, reflect_strength: 0.1, reflect_percent: 0.4,
           file: 'showcase2.png',
           range: 5..9
  showcase trim: 32, trim_radius: 32, margin: 100, face: :right,
           scale: 0.85, offset: 0.95, fill_color: :black,
           reflect_offset: 25, reflect_strength: 0.1, reflect_percent: 0.4,
           file: 'showcase3.png',
           range: 10..14
  showcase trim: 32, trim_radius: 32, margin: 100, face: :right,
           scale: 0.85, offset: 0.95, fill_color: :black,
           reflect_offset: 25, reflect_strength: 0.1, reflect_percent: 0.4,
           file: 'showcase4.png',
           range: 15..18
end
