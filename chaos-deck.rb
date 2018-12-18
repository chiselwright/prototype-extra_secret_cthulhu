require 'game_icons'

deck = Squib.csv(
    file: 'data/extra-secret-cthulhu.csv', # no artwork data in our game data!!
    explode: 'Quantity',
)

# some prerendering prep
version = "v" + Time.new.strftime("%Y%m%d%H%M%S")

TitleBoxColorBG = []
TitleBoxColorFG = []
CardIDs = []
SeenCard = { }
AddToShowcase = []

(0 .. deck.nrows-1).each { |i|
    # add card id
    CardIDs.push("Chaos-%03d" % (i+1) )

    # automatically work out what to showcase (the first time we see a card title)
    row     = deck.row(i)
    title   = row['Title']
    if SeenCard[title] == nil
        SeenCard[title] = 1
        AddToShowcase.push(1)
    else
        AddToShowcase.push(nil)
    end

    # make "play immediately" look different
    if (deck.row(i)['TypeText'] == 'PLAY IMMEDIATELY')
        TitleBoxColorFG.push(:white)
        TitleBoxColorBG.push(:red)
    else
        TitleBoxColorFG.push(:black)
        TitleBoxColorBG.push(:deep_sky_blue)
    end
}
deck['AddToShowcase']       = AddToShowcase
deck['CardID']              = CardIDs
deck['TitleBoxColorBG']     = TitleBoxColorBG
deck['TitleBoxColorFG']     = TitleBoxColorFG

Squib::Deck.new(cards: deck['Title'].size, layout: %w(chaos-deck-layout.yml)) do

  background color: 'white'

  # use the determined colour from the autu-prep loop above
  rect layout: :TitleBox, fill_color: deck['TitleBoxColorBG'], stroke_width: 0
  rect layout: :TypeBox,  fill_color: deck['TitleBoxColorBG'], stroke_width: 0

  # this one's always filled with black
  rect fill_color: :black,   layout: :middle_rect

  # 'Type' icons
  svg data: deck['Type'].map { |t| t!=nil ? GameIcons.get(t).recolor(bg_opacity: 0).string : nil}, layout: 'TypeIcon'

  # things in white
  %w(TypeText).each do |key|
    text str: deck[key], color: deck['TitleBoxColorFG'], layout: key
  end

  # things in black
  %w(Title RuleTop RuleBottom CardID).each do |key|
    text str: deck[key], color: :black, layout: key
  end

  # this is the same on all cards
  text str: version, color: :black, layout: :copyright

  showcaseIndices = deck['AddToShowcase']
  showcaseIndices = (0 .. showcaseIndices.size).reject {|i| showcaseIndices[i].nil? }
  showcaseIndices.each_slice(4).to_a.each_with_index do |sc,i|
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
