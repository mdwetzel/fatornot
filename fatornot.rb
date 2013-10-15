require 'sinatra'

get '/' do
  erb :form
end

post '/' do
  unless params[:weight].empty? || params[:height].empty?
    @weight = params[:weight].to_f
    @height = params[:height].to_f
    
    @bmi = ((@weight / @height ** 2) * 703).round(1)
    
    @category = category(@bmi)
  end
  
  erb :form
end

def category(bmi)
  
  result = Hash.new
  
  case 
    when bmi < 18.5 then  { category: "Underweight", message: "Dude, eat something." }
    when bmi < 24.9 then  { category: "Normal", message: "Congratulations!" }
    when bmi < 29.9 then  { category: "Overweight", message: "Put the cookie down!" }
    when bmi > 30.0 then  { category: "Obese", message: "ALERT ALERT ALERT." }
    else                  { category: "Error!", message: "Something went wrong!" }
  end
end