using System;
using System.Net;
using System.Net.Http;
using System.Text.Json;
using System.Threading.Tasks;

public class PetProfileController
{
    // Метод для обработки POST-запроса добавления профиля питомца
    public async Task<HttpResponseMessage> AddPetProfile(HttpRequestMessage request)
    {
        try
        {
            // Десериализация данных из тела запроса
            var requestBody = await request.Content.ReadAsStringAsync();
            var petData = JsonSerializer.Deserialize<PetProfile>(requestBody);

            if (petData == null || string.IsNullOrEmpty(petData.Name) || string.IsNullOrEmpty(petData.Species))
            {
                return new HttpResponseMessage(HttpStatusCode.BadRequest)
                {
                    Content = new StringContent("Invalid data. Please provide valid pet profile information.")
                };
            }

            // Логика добавления профиля питомца (например, сохранение в БД)
            // Здесь мы просто эмулируем успешное добавление

            // Формируем успешный ответ
            var response = new
            {
                Status = "Success",
                Message = $"Pet profile for {petData.Name} has been successfully created.",
                ProfileDetails = petData
            };

            return new HttpResponseMessage(HttpStatusCode.Created)
            {
                Content = new StringContent(JsonSerializer.Serialize(response), System.Text.Encoding.UTF8, "application/json")
            };
        }
        catch (Exception ex)
        {
            // Обработка ошибок
            return new HttpResponseMessage(HttpStatusCode.InternalServerError)
            {
                Content = new StringContent($"An error occurred: {ex.Message}")
            };
        }
    }
}

// Класс для представления данных о питомце
public class PetProfile
{
    public string Name { get; set; }
    public string Species { get; set; }
    public string Breed { get; set; }
    public DateTime DateOfBirth { get; set; }
    public string Gender { get; set; }
    public string PhotoURL { get; set; }
}
