require 'game_icons'

deck = Squib.csv file: 'data/extra-secret-cthulhu.csv' # no artwork data in our game data!!

Squib::Deck.new(cards: deck['Title'].size, layout: %w(failure-deck.yml)) do
  background color: 'white'

  rect layout: :TitleBox, fill_color: :deep_sky_blue, stroke_width: 0
  rect fill_color: :black,   layout: :middle_rect
  rect fill_color: :red,   layout: :TypeBox, stroke_width: 0

  # 'Type' icons
  svg data: deck['Type'].map { |t| t!=nil ? GameIcons.get(t).recolor(bg_opacity: 0).string : nil}, layout: 'TypeIcon'

  # things in white
  %w(TypeText).each do |key|
    text str: deck[key], color: :white, layout: key
  end

  # things in black
  %w(Title RuleTop RuleBottom).each do |key|
    text str: deck[key], color: :black, layout: key
  end

  showcaseIndices = deck['Showcase']
  showcaseIndices = (0 .. showcaseIndices.size).reject {|i| showcaseIndices[i].nil? }
  showcaseIndices.each_slice(5).to_a.each_with_index do |sc,i|
    showcase trim: 32, trim_radius: 32, margin: 100, face: :right,
            scale: 0.85, offset: 0.95, fill_color: :black,
            reflect_offset: 25, reflect_strength: 0.1, reflect_percent: 0.4,
            file: "showcase_#{i+1}.png",
            range: sc
    hand file: "hand_#{i+1}.png", trim: 37.5, trim_radius: 25, fill_color: '#0000', range: sc
  end

  save_pdf file: 'failure-deck-a4-landscape.pdf',
            height: "8.27in", width: "11.69in", 
            margin: 75, gap: 5, trim: 37
end
