//
//  ContentView.swift
//  ScrollViewAnimation
//
//  Created by Hanlin Chen on 10/2/20.
//

import SwiftUI

struct ContentView: View {
    
    
    
    var body: some View {
        Home()
        
    }
}




struct Home: View{
    @State var placeCards:[PlaceCard] = [
        
        PlaceCard(title: "Golden Bridge", image: "goldenbridge", description: "The Golden Gate Bridge is a suspension bridge spanning the Golden Gate, the one-mile-wide (1.6 km) strait connecting San Francisco Bay and the Pacific Ocean. The structure links the U.S. city of San Francisco, California—the northern tip of the San Francisco Peninsula—to Marin County, carrying both U.S. Route 101 and California State Route 1 across the strait. The bridge is one of the most internationally recognized symbols of San Francisco and California. It was initially designed by engineer Joseph Strauss in 1917. It has been declared one of the Wonders of the Modern World by the American Society of Civil Engineers", expand: false),
        PlaceCard(title: "China Town", image: "chinatown", description: "The Chinatown centered on Grant Avenue and Stockton Street in San Francisco, California, (Chinese: 唐人街; pinyin: tángrénjiē; Jyutping: tong4 jan4 gaai1) is the oldest Chinatown in North America and the largest Chinese enclave outside Asia. It is also the oldest and largest of the four notable Chinese enclaves within San Francisco Since its establishment in 1848 it has been highly important and influential in the history and culture of ethnic Chinese immigrants in North America. Chinatown is an enclave that continues to retain its own customs, languages, places of worship, social clubs, and identity. There are two hospitals, several parks and squares, numerous churches, a post office, and other infrastructure. Recent immigrants, many of whom are elderly, opt to live in Chinatown because of the availability of affordable housing and their familiarity with the culture San Francisco's Chinatown is also renowned as a major tourist attraction, drawing more visitors annually than the Golden Gate Bridge", expand: false),
        PlaceCard(title: "Alcatraz Island", image: "alcatras", description:"Alcatraz Island is located in San Francisco Bay, 1.25 miles offshore from San Francisco, California, United States. The small island was developed with facilities for a lighthouse, a military fortification, a military prison, and a federal prison from 1934 until 21 March 1963", expand:false),
        PlaceCard(title: "Painted Ladies", image: "paintedladies", description: "In American architecture, painted ladies are Victorian and Edwardian houses and buildings repainted, starting in the 1960s, in three or more colors that embellish or enhance their architectural details. The term was first used for San Francisco Victorian houses by writers Elizabeth Pomada and Michael Larsen in their 1978 book Painted Ladies: San Francisco's Resplendent Victorians", expand: false)
        
    ]
    
    
    @State var hero = false
    var body: some View{
        
        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
            VStack{
                HStack{
                    Text("Sanfransico Spotlight").font(.title).fontWeight(.bold)
                    Spacer()
                    Image(systemName:"person.circle").resizable().frame(width: 40, height: 40)
                }.padding()
                VStack{
                    ForEach(0..<placeCards.count){
                        i in
                        GeometryReader{
                            g in
                            CardView(card: $placeCards[i], hero: $hero)
                                .offset(y: self.placeCards[i].expand ? -g.frame(in: .global).minY: 10)
                                .opacity(self.hero ? (self.placeCards[i].expand ? 1:0) : 1)
                                .onTapGesture{
                                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0)){
                                        self.placeCards[i].expand.toggle()
                                        self.hero.toggle()
                                    }
                                }
                        }.frame(height: self.placeCards[i].expand ? UIScreen.main.bounds.height:250)
                    }
                }
            }
        }
    }
}


struct CardView: View {
    @Binding var card: PlaceCard
    @Binding var hero: Bool
    
    var body: some View{
        VStack {
            Image(card.image).resizable().frame(height: self.card.expand ? 350 : 250)
                .cornerRadius(self.card.expand ? 0 : 25).padding(.bottom, 20)
            if card.expand {
                ScrollView(.vertical){
                    VStack{
                        Text(card.title).font(.title).fontWeight(.bold)
                        Text(card.description).font(.headline).fontWeight(.bold).padding(.horizontal)
                    }
                }
            }
        }
        .padding(.horizontal, card.expand ? 0 :20)
        .contentShape(Rectangle())
    }
}


struct PlaceCard:Identifiable {
    let id = UUID()
    var title:String
    var image:String
    var description:String
    var expand:Bool
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
