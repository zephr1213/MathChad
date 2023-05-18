import eel
import requests
from urllib.parse import quote

API_KEY = 'Y47VVG-VV7HVV77U5'

@eel.expose
def solve_algebra_equation(equation):
    url = f'http://api.wolframalpha.com/v1/result?appid={API_KEY}&i={quote(equation)}'
    response = requests.get(url)
    result = response.text.strip()

    if response.status_code == 200:
        return result
    else:
        return None

# Initialize Eel
eel.init('web')

# Start the Eel app
eel.start('index.html', size=(800, 400), port=8080)
