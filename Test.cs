void Main()
{
	Item item = new Item{
	Id = 0,
	Name="Test"
	};
	Console.WriteLine(ToJsonString(item));
}

        public string ToJsonString(object objectToConvertToString)
        {
            return JsonConvert.SerializeObject(objectToConvertToString, Formatting.Indented);
        }
		
		public class Item{
			public string Name {get;set;}
			public int Id {get;set;}
		}