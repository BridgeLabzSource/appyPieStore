// get and store data

import Foundation

class DataManager:NSObject
{
    
    func getData(pageName:String, returndata:@escaping (_ result:[BaseModel])->Void)
    {
        switch pageName
        {
        case PageConstants.HISTORY_PAGE:
             let parser = HistoryParser()
             //parser.parse(params: <#T##Parameters#>, completion: <#T##([BaseModel]) -> Void#>)
             parser.parse(params: HttpRequestBuilder.getHistoryParameters(), completion: { result in
                 returndata(result)
                
             })
      
        default:
            break
            
        }
    }
    
}
