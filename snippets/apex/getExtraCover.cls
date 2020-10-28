public class getExtraCover {
	public getExtrCover(){

	Map<Decimal, Decimal> extraCovers = new Map<Decimal, Decimal>();
		for(Decimal i = 30; i<79; i++){
			Decimal quote = FulfillmentXMLBirthday.GetAverageCover(i);
			Decimal extraCover = FulfillmentXMLBirthday.GetExtraCover(i,quote);
			system.debug('Age: i ' + ' | Extra Cover: ' + extraCover);
			extraCovers.put(i, extraCover);
		}
	}
}