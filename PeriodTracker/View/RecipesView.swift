//
//  RecipesView.swift
//  PeriodTracker
//
//  Created by Beyza Nur Tekerek on 6.01.2025.
//

import SwiftUI

struct RecipesView: View {
    // Örnek tarif verileri
    let recipes = [
        Recipe(
            name: "Zencefilli Limonlu Su",
            image: "tarif1",
            description: """
            Zencefil, regl döneminde rahatlatıcı etkisiyle bilinir ve mideyi yatıştırır. Limon ise bağışıklığı güçlendirir ve vücudu ferahlatır.

            Malzemeler:
                •    1 dilim taze zencefil
                •    1 limon
                •    1 su bardağı su
                •    Birkaç yaprak nane (isteğe bağlı)

            Yapılışı:
                1.    Zencefili ince ince dilimleyin.
                2.    Bir bardağa 1 dilim zencefil ekleyin ve üzerine kaynar suyu dökün.
                3.    Limonu sıkın ve bardağa ekleyin.
                4.    İsteğe bağlı olarak birkaç yaprak nane ekleyip karıştırın.
                5.    Sıcak ya da soğuk olarak tüketebilirsiniz.
            """
        ),
        Recipe(
            name: "Yulaflı Muzlu Smoothie",
            image: "tarif2",
            description:"""
            Yulaf, regl döneminde vücuda ihtiyaç duyduğu enerjiyi sağlayan besleyici bir gıdadır. Muz ise potasyum açısından zengindir ve kramp önleyici özellik gösterir.
            
            Malzemeler:
                •    1 adet muz
                •    1/2 su bardağı yulaf
                •    1/2 su bardağı süt (veya badem sütü)
                •    1 tatlı kaşığı bal
                •    Buz küpleri (isteğe bağlı)
            
            Yapılışı:
                1.    Bütün malzemeleri bir blender’a koyun.
                2.    Karıştırarak pürüzsüz bir kıvam elde edin.
                3.    Soğuk servis yapabilirsiniz.
            """
        ),
        Recipe(
            name: "Ispanaklı Kısır",
            image: "tarif3",
            description: """
            Ispanak, demir kaybını telafi etmeye yardımcı olur ve kramp önleyici özelliklere sahiptir. Kısır, hızlı ve pratik bir yemek alternatifi sunar.

            Malzemeler:
                •    1 su bardağı ince bulgur
                •    1/2 su bardağı zeytinyağı
                •    1 limon suyu
                •    1/2 tatlı kaşığı tuz
                •    1 su bardağı haşlanmış ıspanak
                •    1/4 su bardağı nar ekşisi
                •    1/2 su bardağı doğranmış taze soğan

            Yapılışı:
                1.    Bulguru sıcak suyla ıslatın ve üzerini kapatıp dinlendirin.
                2.    Ispanakları haşlayıp ince ince doğrayın.
                3.    Bulgurun üzerine ıspanakları, taze soğanı ve baharatları ekleyin.
                4.    Limon suyu, zeytinyağı ve nar ekşisini ekleyip karıştırın.
                5.    Soğuk servis yapın.
            """
        ),
        Recipe(
            name: "Yoğurtlu Cevizli Smoothie",
            image: "tarif4",
            description:"""
            Yoğurt ve ceviz, vücudu rahatlatan ve iltihap azaltıcı etkiler yapar. Aynı zamanda bağışıklığı güçlendirir.

            Malzemeler:
                •    1 su bardağı yoğurt
                •    1/4 su bardağı ceviz
                •    1 tatlı kaşığı bal
                •    1/2 çay kaşığı tarçın

            Yapılışı:
                1.    Tüm malzemeleri bir blender’a ekleyin.
                2.    Karıştırarak pürüzsüz bir kıvam elde edin.
                3.    Soğuk olarak içebilirsiniz.
            """
        ),
        Recipe(
            name: "Kabak Çorbası",
            image: "tarif5",
            description: """
            Kabak, sindirimi kolaylaştırır ve vücudu nemlendirir. Ayrıca hafif bir çorba tarifidir.

            Malzemeler:
                •    1 adet kabak
                •    1 tatlı kaşığı zeytinyağı
                •    1/2 soğan
                •    1 diş sarımsak
                •    2 su bardağı sebze suyu
                •    Tuz ve karabiber

            Yapılışı:
                1.    Kabakları soyun ve doğrayın.
                2.    Soğanı ve sarımsağı ince doğrayın.
                3.    Bir tencerede zeytinyağını ısıtın ve soğanları kavurun.
                4.    Kabakları ekleyin ve biraz daha kavurun.
                5.    Sebze suyunu ekleyin ve kabaklar yumuşayıncaya kadar pişirin.
                6.    Karışımı bir blender’dan geçirin ve baharatları ekleyin.
                7.    Sıcak servis yapın.
            """
        ),
        Recipe(
            name: "Fırınlanmış Tatlı Patates",
            image: "tarif6",
            description: """
            Tatlı patates, regl dönemi için enerji verici ve mideyi yatıştırıcı özellik gösterir.

            Malzemeler:
                •    2 adet tatlı patates
                •    1 tatlı kaşığı zeytinyağı
                •    1/2 çay kaşığı tarçın
                •    Tuz ve karabiber

            Yapılışı:
                1.    Tatlı patatesleri soyup dilimleyin.
                2.    Bir tepsiye dizin ve üzerine zeytinyağını, tarçını, tuz ve karabiberi serpin.
                3.    180°C fırında 30-40 dakika kadar pişirin.
                4.    Sıcak olarak servis yapın.            
            """
        )
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Tarifler")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.orange)
                
                ForEach(recipes, id: \.name) { recipe in
                    RecipeCardView(recipe: recipe)
                        .padding(.horizontal, 16) // Kenarlardan boşluk
                }
            }
            .padding(.top, 20) // Sayfanın üst kısmına boşluk eklemek
        }
        .background(Color.white)
//        .navigationBarTitle("Tarifler", displayMode: .inline)
    }
}

struct RecipeCardView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Görsel
            Image(recipe.image)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .cornerRadius(15)
                .clipped()
            
            // Başlık
            Text(recipe.name)
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.bottom, 4)
            
            // Tarif açıklaması
            Text(recipe.description)
                .font(.subheadline)
                .foregroundColor(.black.opacity(0.85))
            
            Divider() // Kartın altına bir ayrım çizgisi ekliyoruz
        }
        .padding() // Kartın iç kenarlarına boşluk ekliyoruz
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.5), radius: 8, x: 0, y: 4)
    }
}

struct Recipe: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var description: String
}

#Preview {
    RecipesView()
}
