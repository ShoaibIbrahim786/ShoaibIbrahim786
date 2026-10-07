public class AnimalsWrapper {
    
    public List<String> animals;

	
	public static AnimalsWrapper parse(String json) {
		return (AnimalsWrapper) System.JSON.deserialize(json, AnimalsWrapper.class);
	}

}