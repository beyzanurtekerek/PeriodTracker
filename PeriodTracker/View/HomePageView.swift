import SwiftUI

struct HomePageView: View {
    
    // MARK: - Variables
    var firstName: String
    @ObservedObject var viewModel: HomePageViewModel

    // MARK: - Views
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack(spacing: 0) {
                    Spacer(minLength: geometry.size.height * 0.1)
                    
                    // Karşılama mesajı
                    HStack(spacing: 0) {
                        Text("Merhaba, ")
                            .font(.largeTitle)
                            .fontWeight(.medium)
                        Text("\(firstName)")
                            .font(.largeTitle)
                            .fontWeight(.medium)
                            .foregroundColor(Color.barbyPink)
                        Text(".")
                            .font(.largeTitle)
                            .fontWeight(.medium)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 25)
                    .padding(.top, 30)
                    
                    Spacer(minLength: geometry.size.height * 0.08)
                    
                    // Çember (regl ve ovulasyon göstermek için)
                    ZStack {
                        // temel circle
                        Circle()
                            .trim(from: 0.001, to: 0.965)
                            .stroke(
                                Color.circleGray,
                                style: StrokeStyle(
                                    lineWidth: 20,
                                    lineCap: .round
                                )
                            )
                            .foregroundColor(Color.gray)
                            .rotationEffect(.degrees(-89))
                        
                        // Regl süresi
                        Circle()
                            .trim(from: 0.001, to: 0.001 + CGFloat(Double(viewModel.homePageModel.periodLength) / Double(max(1, viewModel.homePageModel.cycleLength))))
                            .stroke(
                                Color.bloodRed,
                                style: StrokeStyle(
                                    lineWidth: 20,
                                    lineCap: .round
                                )
                            )
                            .rotationEffect(.degrees(-89))
                            .animation(.easeInOut(duration: 1), value: viewModel.isAnimation)
                        
                        // Ovulasyon süresi
                        Circle()
                            .trim(from: viewModel.homePageModel.ovulationStart, to: viewModel.homePageModel.ovulationEnd)
                            .stroke(
                                Color.lightBlue,
                                style: StrokeStyle(
                                    lineWidth: 20,
                                    lineCap: .round
                                )
                            )
                            .rotationEffect(.degrees(-89))
                            .animation(.easeInOut(duration: 1), value: viewModel.isAnimation)
                        
                        VStack {
                            VStack {
                                HStack {
                                    Text("Bugün, ")
                                        .font(.system(size: geometry.size.width * 0.03))
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                        .padding(.bottom, 10)
                                    Text("\(viewModel.homePageModel.formattedDate).")
                                        .font(.system(size: geometry.size.width * 0.03))
                                        .fontWeight(.regular)
                                        .foregroundColor(.black)
                                        .padding(.bottom, 10)
                                }
                                
                                Text("Sonraki reglin tahmini")
                                    .font(.system(size: geometry.size.width * 0.05))
                                    .fontWeight(.regular)
                                    .foregroundColor(.black.opacity(0.7))
                                Text("\(viewModel.homePageModel.nextPeriodDate)")
                                    .font(.system(size: geometry.size.width * 0.05))
                                    .fontWeight(.bold)
                                    .foregroundColor(.black.opacity(0.7))
                                Text("günü başlayacak.")
                                    .font(.system(size: geometry.size.width * 0.05))
                                    .fontWeight(.regular)
                                    .foregroundColor(.black.opacity(0.7))
                                    .padding(.bottom, 10)
                            }
                        }
                        .multilineTextAlignment(.center)
                    }
                    .frame(width: geometry.size.width * 0.65, height: geometry.size.width * 0.65)
                    .position(x: geometry.size.width / 2, y: geometry.size.height * 0.2)
                    .onAppear {
                        viewModel.startAnimation()
                    }
                    
                    // "Sizin Döngünüz" Başlığı
                    Text("Sizin Döngünüz")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 25)
                        .padding(.bottom, 20)
                    
                    // Bu kısımdan sonra, List yerine VStack kullanıyoruz.
                    VStack(spacing: 20) {
                        // İlk Regl Tarihi Ekleme
                        NavigationLink(destination: FirstPeriodDateView(firstPeriodDate: $viewModel.homePageModel.firstPeriodDate)) {
                            HStack {
                                Text("İlk Regl Tarihi")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Spacer()
                                Text("\(viewModel.homePageModel.formattedFirstPeriodDate)")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 2))
                        }
                        
                        NavigationLink(destination: PeriodLengthView(periodLength: $viewModel.homePageModel.periodLength)) {
                            HStack {
                                Text("Regl Süresi")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Spacer()
                                Text("\(viewModel.homePageModel.periodLength) gün")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 2))
                        }
                        
                        NavigationLink(destination: CycleLengthView(cycleLength: $viewModel.homePageModel.cycleLength)) {
                            HStack {
                                Text("Döngü Süresi")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Spacer()
                                Text("\(viewModel.homePageModel.cycleLength) gün")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 2))
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.bottom, 120)
                }
                .background(Color.white)
                .ignoresSafeArea(edges: .all)
            }
        }
    }
}



struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView(firstName: "Beyza", viewModel: HomePageViewModel(homePageModel: HomePageModel(periodLength: 5, cycleLength: 28, firstPeriodDate: Date())))
    }
}
